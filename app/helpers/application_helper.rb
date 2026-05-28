module ApplicationHelper
  def page_header(title, subtitle = nil, &actions)
    content = tag.div(class: "mb-8 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between") do
      tag.div do
        tag.h1(title, class: nil) +
          (subtitle.present? ? tag.p(subtitle, class: "mt-2 max-w-2xl text-stone-600") : "".html_safe)
      end +
        (actions ? capture(&actions) : "".html_safe)
    end
    content
  end

  def form_field(form, attribute, type: :text_field, label: nil, **options)
    label_text = label || attribute.to_s.humanize
    errors = form.object.errors.full_messages_for(attribute)

    tag.div(class: "space-y-1") do
      form.label(attribute, label_text, class: "form-label") +
        form.public_send(type, attribute, { class: input_class_for(type) }.merge(options)) +
        safe_join(errors.map { |message| tag.div(message, class: "field-error") })
    end
  end

  private

  def input_class_for(type)
    type == :textarea ? "form-textarea" : "form-input"
  end
end
