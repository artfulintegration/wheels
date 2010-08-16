module Wheels
  module ActiveRecordExtensions
    def commentable_tags
      class_eval do
        after_save.reject! {|callback| callback.method.to_s == 'save_tags' }

        def save_commentable_tags
          tagging_contexts.each do |context|
            next unless tag_list_cache_set_on(context)

            tag_list = tag_list_cache_on(context).uniq

            #  Do it normal like, but get the taggings, too.


            # Find existing tags or create non-existing tags:
            tag_list = ActsAsTaggableOn::Tag.find_or_create_all_with_like_by_name(tag_list)

            current_tags = tags_on(context)
            old_tags     = current_tags - tag_list
            new_tags     = tag_list     - current_tags

            # Find taggings to remove:
            old_taggings = taggings.where(:tagger_type => nil, :tagger_id => nil,
                                          :context => context.to_s, :tag_id => old_tags).all

            if old_taggings.present?
              # Destroy old taggings:
              ActsAsTaggableOn::Tagging.destroy_all :id => old_taggings.map(&:id)
            end

            # Create new taggings:
            new_tags.each do |tag|
              taggings.create!(:tag_id => tag.id, :context => context.to_s, :taggable => self)
            end
          end
        end
        after_save :save_commentable_tags

      end
    end
  end
end

