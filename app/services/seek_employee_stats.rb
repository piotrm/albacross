class SeekEmployeeStats
  def self.call(dept_no)
    self.new(dept_no).call
  end

  def initialize(dept_no)
    @dept_no = dept_no
  end

  def call
    raw_stats = fetch_stats
    raw_stats.total > 0 ? format_stats(raw_stats) : []
  end

  private
  attr_reader :dept_no

  def fetch_stats
    Department.search(query: { match: { _id: dept_no } }).results
  end

  def format_stats(raw_stats)
    raw_stats.first._source.stats_per_employee.map{|x| x.to_h.symbolize_keys }
  end
end
