class HamlFormBuilder < ActionView::Helpers::FormBuilder
  
  @@default_text_field_size = 50

  cattr_accessor :dl_options, :dt_options, :dd_options, :label_name,:label_options, :label_value,:label_method,:input_options,:fieldset_options
  

  %w[text_field password_field text_area check_box date_select].each do |method_name|
    define_method(method_name) do |field_name, *args|
      options = args.extract_options!
      
      @dl_options = options.delete(:dl_options) || {:class => 'campos'}
      @dt_options = options.delete(:dt_options) || {:class => 'strong'}
      @dd_options = options.delete(:dd_options) || {}
      @label_name = options.delete(:label_name) || field_name.to_s.humanize.downcase
      @label_method = options.delete(:label_method) || ''
      @label_options = options.delete(:label_options) || {}
      @label_value = options.delete(:label_value) || {}
      @input_options = options.delete(:input_options) || {}
      
      #crio label dentro de dt
      label = @template.content_tag(:dt,label(@label_name,@label_value,@label_options),@dt_options)
      #crio input dentro de dd
      input = @template.content_tag(:dd,super,@dd_options)
      #crio input + label dentro de dl
      @template.content_tag(:dl,label+input,@dl_options)
    end
  end
  def submit(value='Save',options={:class => 'inline'})
    @botao_div = options.delete(:div_options) || {:class => 'botao-submit'}
    @template.content_tag(:div, super, @botao_div)
  end
end
