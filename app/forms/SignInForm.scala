package forms

import play.api.data.Form
import play.api.data.Forms._

/**
 * The form which handles the submission of the credentials.
 */
object SignInForm {

  /**
   * A play framework form.
   */
  val form = Form{
    tuple(
      "login" -> text,
      "password" -> nonEmptyText
    )
  }
  case class Data(
                   login: String,
                   password: String)
}