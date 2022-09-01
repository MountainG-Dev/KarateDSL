package perfAutomation.simulations

import com.intuit.karate.gatling.KarateProtocol
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.feeder.Feeder
import io.gatling.core.structure.ScenarioBuilder

import scala.concurrent.duration._
import scala.language.postfixOps
import perfAutomation.createTokens.CreateTokens

class perfTest extends Simulation {

  CreateTokens.createAccessTokens()

  val protocol: KarateProtocol = karateProtocol(
//    "/booking/{bookingID}" -> Nil
    "/api/articles/{articleId}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  /* AL SER UNA LIBRERÍA EN INGLES, CONSIDERA SEPARADOR DE COLUMNAS "," */
  val csvFeeder = csv("articles.csv").circular()
  val tokenFeeder = Iterator.continually(Map("token" -> CreateTokens.getNextToken))

//  val createBooking = scenario("CreateAndDelete").feed(csvFeeder).exec(karateFeature("classpath:perfAutomation/simulations/restful-createAnddelete.feature"))
  val createArticle: ScenarioBuilder = scenario("Test Case 01 / Registrar y eliminar nuevo articulo")
    .feed(csvFeeder)
    .feed(tokenFeeder)
    .exec(karateFeature("classpath:perfAutomation/simulations/conduit-createAnddelete.feature"))

    setUp(
        createArticle.inject(
          atOnceUsers(1),
          nothingFor(4 seconds),
          constantUsersPerSec(1) during(3 seconds),
          constantUsersPerSec(2) during(10 seconds),
          rampUsersPerSec(2) to 10 during(20 seconds),
          nothingFor(5 seconds),
          constantUsersPerSec(2) during(10 seconds),
        ).protocols(protocol)

        /* INYECTAR 10 USUARIOS POR 5 SEGUNDOS */
//        createArticle.inject(
      //        rampUsers(10) during(5 seconds)
      //        ).protocols(protocol)
        /* INYECTAR 10 USUARIOS POR CADA SEGUNDOS */
//        createArticle.inject(
//              atOnceUsers(5)
//              ).protocols(protocol)
    )

}