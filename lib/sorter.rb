require 'opentelemetry/sdk'
require 'opentelemetry/exporter/jaeger'
require 'opentelemetry/instrumentation/all'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'sooortinnng'

  jaeger_exporter = OpenTelemetry::Exporter::Jaeger::AgentExporter.new(
    host: 'jaeger',
    port: 6831
  )

  span_processor = OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(jaeger_exporter)
  c.add_span_processor(span_processor)

  c.use_all
end

tracer_provider = OpenTelemetry.tracer_provider

class Sorter
  attr_accessor :strategy
  attr_reader :comparisons, :swaps

  def initialize(strategy)
    @strategy = strategy
    @tracer = OpenTelemetry.tracer_provider.tracer('SortingTracer', '1.0.0')
    reset_metrics
  end

  def sort(array)
    reset_metrics
    @tracer.in_span("sort_#{@strategy.class}") do |span|
      span.set_attribute("array_size", array.length)

      start_time = Time.now
      result = @strategy.sort(array.dup, self)
      end_time = Time.now
      execution_time = (end_time - start_time) * 1000

      span.set_attribute("sorted", result.join(","))
      span.set_attribute("execution_time_ms", execution_time)
      span.set_attribute("comparisons", @comparisons)
      span.set_attribute("swaps", @swaps)
      span.add_event("Sorting completed", attributes: {
        "algorithm" => @strategy.class.to_s,
        "comparisons" => @comparisons,
        "swaps" => @swaps
      })

      result
    end
  end

  def increment_comparisons
    @comparisons += 1
  end

  def increment_swaps
    @swaps += 1
  end

  private

  def reset_metrics
    @comparisons = 0
    @swaps = 0
  end
end