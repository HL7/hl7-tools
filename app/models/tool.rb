class Tool < ActiveRecord::Base
  has_many :tool_assessments
  has_many :tool_dependencies
  has_many :tool_technologies
  has_many :tool_persons
  has_many :tool_notes
  has_many :tool_users

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
end
