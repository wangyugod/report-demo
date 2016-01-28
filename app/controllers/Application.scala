package controllers

import forms.SignInForm
import play.api.mvc._

import scala.concurrent.Future

class Application extends Controller with Users with Secured {

  def index = isAuthenticatedAsync { implicit request =>
    Future.successful(Ok(views.html.index("hello")))
  }

  /** Handles the Sign In action.
    *
    * @return The result to display.
    */
  def signIn = Action.async { implicit request =>
    Future.successful(Ok(views.html.login(SignInForm.form)))
  }

  /**
   * Logout, clear whole session
   * @return
   */
  def logout = Action.async {
    implicit request =>
      Future.successful(Redirect(routes.Application.signIn()).withNewSession)
  }
}
