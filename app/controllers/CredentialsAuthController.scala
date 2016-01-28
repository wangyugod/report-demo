package controllers

import javax.inject.Inject

import forms.SignInForm

import models.services.{Credentials, CredentialsAuthenticator}
import play.api.Logger
import play.api.libs.concurrent.Execution.Implicits._
import play.api.mvc._

import scala.concurrent.Future
import scala.language.postfixOps

/**
 * The credentials auth controller.
 *
 * @param credentialsProvider The credentials provider.
 */
class CredentialsAuthController @Inject()(credentialsProvider: CredentialsAuthenticator) extends Controller with Users{


  /**
   * Authenticates a user against the credentials provider.
   *
   * @return The result to display.
   */
  def authenticate = Action.async { implicit request =>
    SignInForm.form.bindFromRequest.fold(
      form => Future.successful(BadRequest(views.html.login(form))),
      data => {
        val credentials = Credentials(data._1, data._2)
        credentialsProvider.authenticate(credentials).flatMap { user =>
          val result = Redirect(routes.Application.index())
          Future.successful(result.withSession(request.session + (LOGIN_KEY -> user.login)))
        }
      }.recover {
        case e: Exception =>
          Logger.debug("authentication failed")
          Redirect(routes.Application.signIn()).flashing("error" -> "invalid.credentials")
      }
    )
  }
}
