package us.shalominattii.aegentix

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import java.net.URI

class AegentixSyncWorker(
    appContext: Context,
    params: WorkerParameters
) : CoroutineWorker(appContext, params) {
    override suspend fun doWork(): Result {
        val nodeId = inputData.getString("node_id") ?: return Result.failure()
        val endpoint = inputData.getString("endpoint") ?: return Result.failure()
        return try {
            val host = AegentixHost(applicationContext, nodeId, URI(endpoint))
            host.emit("heartbeat", "preapproved", mapOf("status" to "online"))
            Result.success()
        } catch (_: Exception) {
            Result.retry()
        }
    }
}
