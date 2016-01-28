package modules

import com.google.inject.Provides
import models.services.CredentialsAuthenticator
import net.codingwell.scalaguice.ScalaModule
import play.api.libs.ws.WSClient

/**
 * The Guice module which wires all Silhouette dependencies.
 */
class GuiceModule extends ScalaModule {

  /**
   * Configures the module.
   */
  def configure() {
  }


  @Provides
  def provideCredentialsAuthenticator(wsClient: WSClient):CredentialsAuthenticator ={
    new CredentialsAuthenticator(wsClient)
  }
}