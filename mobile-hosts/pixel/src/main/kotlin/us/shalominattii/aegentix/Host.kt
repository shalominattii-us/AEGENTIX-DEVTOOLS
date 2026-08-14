package us.shalominattii.aegentix

import android.content.Context
import java.io.File
import java.net.HttpURLConnection
import java.net.URI
import java.security.MessageDigest
import java.time.Instant
import java.util.UUID
import org.json.JSONObject

class AegentixJournal(context: Context) {
    private val file = File(context.filesDir, "aegentix-events.jsonl")
    @Synchronized fun append(envelope: JSONObject) {
        file.appendText(envelope.toString() + "\n", Charsets.UTF_8)
    }
}

class AegentixHost(
    private val context: Context,
    private val nodeId: String,
    private val endpoint: URI
) {
    private val journal = AegentixJournal(context)

    fun emit(type: String, policy: String = "guardian-required", payload: Map<String, String>): JSONObject {
        val payloadJson = JSONObject(payload)
        val hash = sha256(payloadJson.toString().toByteArray(Charsets.UTF_8))
        val envelope = JSONObject()
            .put("event_id", UUID.randomUUID().toString())
            .put("node_id", nodeId)
            .put("type", type)
            .put("timestamp", Instant.now().toString())
            .put("causal_parent", JSONObject.NULL)
            .put("payload_hash", hash)
            .put("policy", policy)
            .put("payload", payloadJson)

        journal.append(envelope) // event first
        post(envelope)
        return envelope
    }

    private fun post(envelope: JSONObject) {
        val connection = endpoint.resolve("events").toURL().openConnection() as HttpURLConnection
        try {
            connection.requestMethod = "POST"
            connection.setRequestProperty("Content-Type", "application/json")
            connection.doOutput = true
            connection.outputStream.use { it.write(envelope.toString().toByteArray(Charsets.UTF_8)) }
            connection.responseCode
        } finally {
            connection.disconnect()
        }
    }

    private fun sha256(data: ByteArray): String = MessageDigest.getInstance("SHA-256")
        .digest(data).joinToString("") { "%02x".format(it) }
}
