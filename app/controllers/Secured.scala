package controllers


import models.User
import play.api.mvc._
import play.api.libs.Files.TemporaryFile
import play.api.Logger
import scala.concurrent.Future

/**
 *
 * User: simonwang
 * Date: 2016/1/27.
 *
 * Time: 4:35 PM
 * To change this template use File | Settings | File Templates.
 */
trait Secured {


  def loginKey = "user_login"

  /**
   * Retrieve the connected user email.
   */
  protected def username(request: RequestHeader) = request.session.get(loginKey)

  /**
   * Redirect to login if the user in not authorized.
   */
  protected def onUnauthorized(request: RequestHeader) = {
    /*val forward = request.getQueryString("forward") match {
      case Some(url) => url
      case _ => request.uri
    }*/
    Results.Redirect(routes.Application.signIn())
  }

  // --

  /**
   * Action for authenticated users.
   */
  def isAuthenticated(f: Request[AnyContent] => Result) = Security.Authenticated(username, onUnauthorized) {
    user => Action(f)
  }

  def isAuthenticatedAsync(f: Request[AnyContent] => Future[Result]) = Security.Authenticated(username, onUnauthorized) {
    user => Action.async(f)
  }


  def isAuthenticatedWithMultipartParser(parser: BodyParser[MultipartFormData[TemporaryFile]])(f: Request[MultipartFormData[TemporaryFile]] => Result) = Security.Authenticated(username, onUnauthorized) {
    user => Action(parser)(f)
  }
}

trait Users {
  val LOGIN_KEY = "user_login"
  val USER_NAME = "user_name"
  val USER_ID = "user_id"

  implicit def toUser(implicit session: Session): Option[User] = {
    session.get(LOGIN_KEY) match {
      case Some(login) =>
        Some(User(session.get(LOGIN_KEY).get))
      case None =>
        None
    }
  }
}
