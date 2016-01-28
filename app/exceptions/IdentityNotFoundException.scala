package exceptions

/**
 * Created by Simon Wang on 2016/1/27.
 */
class IdentityNotFoundException(msg: String, cause: Throwable = null) extends Exception(msg, cause)