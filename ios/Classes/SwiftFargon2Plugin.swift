import CatCrypto
import Flutter
import UIKit

public class SwiftFargon2Plugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "fargon2", binaryMessenger: registrar.messenger())
        let instance = SwiftFargon2Plugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "hash":
            if let args = call.arguments as? [String: Any],
               let mode = args["mode"] as? String,
               let password = args["password"] as? String,
               let salt = args["salt"] as? String,
               let hashLength = args["hash_length"] as? Int,
               let iterations = args["iterations"] as? Int,
               let paralelism = args["parallelism"] as? Int,
               let memory = args["memory_kibibytes"] as? Int
            {
                let hashString = hash(
                    mode: mode,
                    password: password,
                    salt: salt,
                    hashLength: hashLength,
                    iterations: iterations,
                    parallelism: paralelism,
                    memoryKibiBytes: memory
                )
                result(hashString)
                return
            }
            result(FlutterError(code: "bad args", message: nil, details: nil))
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    }

    private func hash(
        mode: String,
        password: String,
        salt: String,
        hashLength: Int,
        iterations: Int,
        parallelism: Int,
        memoryKibiBytes: Int
    ) -> String {
        var argon2mode: CatArgon2Mode
        switch mode {
        case "argon2i":
            argon2mode = .argon2i
        case "argon2d":
            argon2mode = .argon2d
        case "argon2id":
            argon2mode = .argon2id
        default:
            argon2mode = .argon2id
        }

        let argon2Crypto = CatArgon2Crypto()
        argon2Crypto.context.mode = argon2mode
        argon2Crypto.context.hashResultType = .hashRaw
        argon2Crypto.context.salt = salt
        argon2Crypto.context.hashLength = hashLength
        argon2Crypto.context.iterations = iterations
        argon2Crypto.context.parallelism = parallelism
        argon2Crypto.context.memory = memoryKibiBytes

        return argon2Crypto.hash(password: password).base64StringValue()
    }
}
