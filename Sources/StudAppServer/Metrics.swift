import Kitura
import SwiftMetrics
import SwiftMetricsDash
import SwiftMetricsPrometheus
import LoggerAPI

private var swiftMetrics: SwiftMetrics?
private var swiftMetricsDash: SwiftMetricsDash?
private var swiftMetricsPrometheus: SwiftMetricsPrometheus?

func initializeMetrics(in router: Router) {
    do {
        let metrics = try SwiftMetrics()
        let dashboard = try SwiftMetricsDash(swiftMetricsInstance: metrics, endpoint: router)
        let prometheus = try SwiftMetricsPrometheus(swiftMetricsInstance: metrics, endpoint: router)

        swiftMetrics = metrics
        swiftMetricsDash = dashboard
        swiftMetricsPrometheus = prometheus
        Log.info("Initialized metrics.")
    } catch {
        Log.warning("Failed to initialize metrics: \(error)")
    }
}
