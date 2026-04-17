// IShizukuService.aidl
package moe.shizuku.server;

import moe.shizuku.server.IRemoteProcess;

/**
 * Main Shizuku service interface.
 * Provides privileged operations to client applications that have been granted permission.
 */
interface IShizukuService {

    /**
     * Returns the version code of the running Shizuku service.
     */
    int getVersion() = 1;

    /**
     * Returns the uid of the Shizuku server process (typically 0 for root or 2000 for ADB).
     */
    int getUid() = 2;

    /**
     * Returns the Linux user ID of the calling application.
     */
    int getCallingUid() = 3;

    /**
     * Check if the calling package has been granted Shizuku permission.
     *
     * @param packageName the package name to check
     * @param version     the API version requested by the client
     * @return PackageManager.PERMISSION_GRANTED or PackageManager.PERMISSION_DENIED
     */
    int checkPermission(String packageName, int version) = 4;

    /**
     * Execute a command in a privileged shell and return a handle to the remote process.
     *
     * @param cmd         command and arguments
     * @param env         environment variables (key=value), may be null
     * @param dir         working directory, may be null
     * @return an IRemoteProcess representing the spawned process
     */
    IRemoteProcess newProcess(in String[] cmd, in String[] env, String dir) = 5;

    /**
     * Attach a client application to the Shizuku service.
     * Must be called before using other privileged APIs.
     *
     * @param packageName the calling application's package name
     * @param version     the API version used by the client
     */
    void attachApplication(String packageName, int version) = 6;

    /**
     * Request the service to exit. Only callable by privileged callers.
     */
    void exit() = 7;
}