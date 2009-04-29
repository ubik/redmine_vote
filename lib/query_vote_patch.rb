require_dependency 'query'

module QueryVotePatch
  def self.included(base)
    base.class_eval <<-END
      @@available_columns += [QueryColumn.new(:votes_value, :sortable => "#{Issue.table_name}.votes_value")]
END
  end
end

Query.send :include, QueryVotePatch
