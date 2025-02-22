# `have_attr_reader` matcher for attr_reader
RSpec::Matchers.define :have_attr_reader do |field|
  match do |object_instance|
    object_instance.respond_to?(field)
  end

  failure_message do |object_instance|
    "expected attr_reader for #{field} on #{object_instance}"
  end

  failure_message_when_negated do |object_instance|
    "expected attr_reader for #{field} not to be defined on #{object_instance}"
  end

  description do |object_instance|
    "has attr_reader for #{field} on the #{object_instance.class} instance"
  end
end

# `have_attr_writer` matcher for attr_writer
RSpec::Matchers.define :have_attr_writer do |field|
  match do |object_instance|
    object_instance.respond_to?("#{field}=")
  end

  failure_message do |object_instance|
    "expected attr_writer for #{field} on #{object_instance}"
  end

  failure_message_when_negated do |object_instance|
    "expected attr_writer for #{field} not to be defined on #{object_instance}"
  end

  description do |object_instance|
    "has attr_writer for #{field} on the #{object_instance.class} instance"
  end
end

# `have_attr_accessor` matcher for attr_accessor
RSpec::Matchers.define :have_attr_accessor do |field|
  match do |object_instance|
    object_instance.respond_to?(field) && object_instance.respond_to?("#{field}=")
  end

  failure_message do |object_instance|
    "expected attr_accessor for #{field} on #{object_instance}"
  end

  failure_message_when_negated do |object_instance|
    "expected attr_accessor for #{field} not to be defined on #{object_instance}"
  end

  description do |object_instance|
    "has attr_accessor for #{field} on the #{object_instance.class} instance"
  end
end
