class Tool < ActiveRecord::Base
  before_validation :remove_array_empty

  has_many :tool_assessments
  has_many :tool_dependencies
  has_many :tool_technologies
  has_many :tool_persons
  has_many :tool_notes
  has_many :tool_users

  validates :name, presence: true
  validate :check_internal
  validate :check_active

  validates :functional_area, code: {table: 'func-area', array: true}
  validates :license, code: {table: 'license'}
  validates :product, code: {table: 'product', array: true}

  def functional_tags
    tags = []
    if functional_area
      functional_area.each do |fn_area|
        code = CodeValue.find_by(code_table: 'func-area', code: fn_area)
        tags << code.print_name if code
      end
    end
    tags
  end

  def product_tags
    tags = []
    if product
      product.each do |fn_area|
        code = CodeValue.find_by(code_table: 'product', code: fn_area)
        tags << code.print_name if code
      end
    end
    tags
  end

  def last_assessment
    tool_assessments.order(assessment_date: :desc).limit(1).first
  end

  def license_name
    if license
      code = CodeValue.find_by(code_table: 'license', code: license)
      code.print_name
    else
      nil
    end
  end

  def self.query(search_params)
    the_arel = self.arel_table
    query = the_arel.project(the_arel[Arel.star])

    if search_params.present?
      filters = build_where(search_params)
      if filters
        Rails.logger.debug filters.to_sql
        query = query.where(filters)
      end
    end

    self.find_by_sql(query)
  end

  def self.build_where(search_params)
    the_arel = self.arel_table
    where_filter = nil

    unless search_params.search_text.empty?
      text_list = search_params.search_text.split
      tsvector = Arel::Nodes::SqlLiteral.new("to_tsvector('english'," +
                                                 " name || ' ' || description || ' ' || purpose)")
      tsquery  = Arel::Nodes::SqlLiteral.new("to_tsquery('#{text_list.join(' | ')}')")
      where_filter = and_where(where_filter,
                               Arel::Nodes::InfixOperation.new('@@', tsvector, tsquery))
    end

    if search_params.product.count > 0
      where_filter = and_where(where_filter,
                               the_arel[:product].overlap(search_params.product))
    end

    if search_params.area.count > 0
      where_filter = and_where(where_filter,
                               the_arel[:functional_area].overlap(search_params.area))
    end

    where_filter
  end

  def self.and_where(existing, new_filter)
    if existing
      existing.and(new_filter)
    else
      new_filter
    end
  end

  private
  def check_internal
    if self.internal.nil?
      errors.add(:internal, :blank)
    else
      errors.add(:internal, 'must be true or false') unless self.internal.in? [true, false]
    end
  end

  def check_active
    if self.active.nil?
      errors.add(:active, :blank)
    else
      errors.add(:active, 'must be true or false') unless self.active.in? [true, false]
    end
  end

  def remove_array_empty
    unless functional_area.nil?
      functional_area.reject! { |l| l.empty? }
    end
    unless product.nil?
      product.reject! { |l| l.empty? }
    end
  end
end
