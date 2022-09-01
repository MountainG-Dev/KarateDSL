package apiAutomation.restful.performance.simulations

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

import scala.language.postfixOps


class perfTest extends Simulation {
  val protocol = karateProtocol()

  val create = scenario("CreateAndDelete").exec(karateFeature("classpath:apiAutomation/restful/performance/simulations/restful-createAnddelete.feature"))

    setUp(
        create.inject(rampUsers(10) during(5 seconds)).protocols(protocol)
    )

}