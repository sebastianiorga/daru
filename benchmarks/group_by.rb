$:.unshift File.expand_path("../../lib", __FILE__)

require 'benchmark'
require 'daru'

data = Daru::DataFrame.from_csv 'MOCK_DATA.csv'

Benchmark.bm do |x|
  x.report("Single column grouping") do
    @single = data.group_by(['last_name'])
  end

  x.report("Multi-column grouping") do
    @multi = data.group_by(['first_name', 'last_name'])
  end

  x.report("Single mean") do
    @single.mean
  end

  x.report("Multi mean") do
    @multi.mean
  end
end

#                    ===== Benchmarks =====
#
#                          user     system      total        real
# Single column grouping 0.000000   0.000000   0.000000   (0.000356)
# Multi-column grouping  0.000000   0.000000   0.000000   (0.000958)
# Single mean            0.000000   0.000000   0.000000   (0.000865)
# Multi mean             0.000000   0.000000   0.000000   (0.002748)

#                    ===== Benchmarks : MOCK_DATA, using old GroupBy#initialize =====
#
#                           user     system      total        real
# Single column grouping  1.490000   0.000000   1.490000 (  1.489592)
# Multi-column grouping   4.630000   0.010000   4.640000 (  4.631676)
# Single mean             0.110000   0.000000   0.110000 (  0.110390)
# Multi mean              0.270000   0.000000   0.270000 (  0.272381)

#                    ===== Benchmarks : MOCK_DATA, using new GroupBy#initialize =====
#
#                           user     system      total        real
# Single column grouping  0.060000   0.000000   0.060000 (  0.061741)
# Multi-column grouping   0.030000   0.000000   0.030000 (  0.033507)
# Single mean             0.120000   0.000000   0.120000 (  0.120006)
# Multi mean              0.280000   0.000000   0.280000 (  0.279207)
