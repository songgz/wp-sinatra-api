module WordpressApi
  module Util
    module Paginates

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def paginate(params = {})
          cursor_field = :created_at
          limit = params.key?(:limit) ? params[:limit] : Configs.pagination.limit
          if limit
            if params.key?(:after)
              collection = self.all(:"#{cursor_field}.gt" => params[:after], :limit => limit)
            elsif params.key?(:before)
              collection = self.all(:"#{cursor_field}.lt" => params[:before], :limit => limit)
            elsif params.key?(:page)
              collection = self.all(:offset => (params[:page] - 1) * limit, :limit => limit)
            else
              collection = self.all(:limit => limit)
            end

            after = (collection.max_by{ |o| o.send(cursor_field) }.send(cursor_field) + 1).to_time.to_i
            before = (collection.min_by{ |o| o.send(cursor_field) }.send(cursor_field) - 1).to_time.to_i
            
            { data: collection, cursor: { after: after, before: before } }
          else
            self
          end
        end

      end

    end
  end
end