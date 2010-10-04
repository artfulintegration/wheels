require 'action_view'

class HtmlWriter
  include ActionView::Helpers::TagHelper

  def initialize(representation={})
    @representation = representation
  end

  #  Wanna be able to do:
  #    HtmlWriter.new.div.div(:id=>:nice, :cool=>:bar).a('Cool', :href=>'http://...')
  HtmlWriter.new.div[:fieldName].div.id('nice') {|h|
    h.div(@page.comments) {|ht, comment|
      ht.div

    }
  }

  def method_missing(sym, *args, &block)
    if args[0].is_a? Array
      #  Then the first argument is an array of objects.
    end
    @representation[sym] = {:args=>args[0]}
    if block_given?
      block.call(self)
    end
    return HtmlWriter.new(@representation[sym])
  end

  def val(value)
    @representation[:value] = value
    return self
  end

  def [](html_class)
    @representation[:args][:class] = html_class.to_s
    return self
  end

  def id(_id)
    @representation[:args][:class] = _id.to_s
  end

  def html
    concat

  end
end

