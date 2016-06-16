class Tool < ActiveRecord::Base
  has_many :tool_assessments
  has_many :tool_dependencies
  has_many :tool_technologies
  has_many :tool_persons
  has_many :tool_notes

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
    if standard
      standard.each do |fn_area|
        code = CodeValue.find_by(code_table: 'standard', code: fn_area)
        tags << code.print_name if code
      end
    end
    tags
  end

  def self.query(search_params)
    all
  end

  def self.return_join(query)
    the_arel = self.arel_table
    smoosh_family = Arel::Nodes::NamedFunction.new('array_to_string',
                                                   [the_arel[:family], Arel::Nodes.build_quoted(' ')])
    smoosh_given = Arel::Nodes::NamedFunction.new('array_to_string',
                                                  [the_arel[:given], Arel::Nodes.build_quoted(' ')])
    return_conditions = nil

    if query.has_key?(:name)
      if query[:name].is_a?(Array)
        query_list = query[:name]
      else
        query_list = [query[:name]]
      end

      query_list.each do |the_query|
        return_conditions = base_join(return_conditions).
            and(Arel::Nodes::InfixOperation.new('@@', smoosh_family,
                                                Arel::Nodes.build_quoted(the_query[:value])).
                or(Arel::Nodes::InfixOperation.new('@@', smoosh_given,
                                                   Arel::Nodes.build_quoted(the_query[:value]))))
      end
    else
      if query.has_key?(:given)
        if query[:given].is_a?(Array)
          query_list = query[:given]
        else
          query_list = [query[:given]]
        end

        query_list.each do |the_query|
          return_conditions = base_join(return_conditions).
              and(Arel:: Nodes::InfixOperation.new('@@', smoosh_given,
                                                   Arel::Nodes.build_quoted(the_query[:value])))
        end
      end

      if query.has_key?(:family)
        if query[:family].is_a?(Array)
          query_list = query[:family]
        else
          query_list = [query[:family]]
        end

        query_list.each do |the_query|
          return_conditions = base_join(return_conditions).
              and(Arel:: Nodes::InfixOperation.new('@@', smoosh_family,
                                                   Arel::Nodes.build_quoted(the_query[:value])))
        end
      end
    end

    return_conditions
  end

  def and_where(existing, new_filter)
    if existing
      existing.and(new_filter)
    else
      new_filter
    end
  end
end
