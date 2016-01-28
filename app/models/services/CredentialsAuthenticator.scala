package models.services

import javax.inject.Inject

import exceptions.IdentityNotFoundException
import models.User
import play.api.Play
import play.api.libs.json.Json
import play.api.libs.ws.WSClient

import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global

/**
 * Created by Simon Wang on 2016/1/26.
 */
class CredentialsAuthenticator @Inject()(client: WSClient) {
  import CredentialsAuthenticator._
  /**
   * Authenticates a user with its credentials.
   *
   * @param credentials The credentials to authenticate with.
   * @return The login info if the authentication was successful, otherwise a failure.
   */
  def authenticate(credentials: Credentials): Future[User] = {
    val loginData = Json.obj(
      "login" -> credentials.login,
      "password" -> credentials.password
    )
    /*credentials match {
      case Credentials("9000", "000000") =>
        Future.successful(User("9000"))
      case _ =>
        throw new IdentityNotFoundException(UnknownCredentials)
    }*/
    val loginUrl = Play.current.configuration.getString("service.login.url").get
    client.url(loginUrl).withHeaders("Content-Type" -> "application/json").post(loginData).map{
      response =>
        (response.json \ "success").as[Boolean] match {
          case true =>
            User(credentials.login)
          case _ =>
            throw new IdentityNotFoundException(UnknownCredentials)
        }
    }
  }
}

object CredentialsAuthenticator{
  val ID = "login"
  val UnknownCredentials = "[Play][%s] Could not find auth info for given credentials"
}

case class Credentials(login: String, password: String)
