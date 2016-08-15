RSpec::Matchers.define :fail_with_null do |attribute|
  match do |actual|
    actual.send("#{attribute}=", nil)
    !actual.valid?
  end
  failure_message do |actual|
    actual.errors.full_messages.push(
        "#{actual.class.name} should not be valid without #{attribute.to_s}").join("\n")
  end
end

RSpec::Matchers.define :pass_with_null do |attribute|
  match do |actual|
    actual.send("#{attribute}=", nil)
    actual.valid?
  end
  failure_message do |actual|
    actual.errors.full_messages.push(
        "#{actual.class.name} should be valid without #{attribute.to_s}").join("\n")
  end
end

RSpec::Matchers.define :fail_with_non_numeric do |attribute|
  match do |actual|
    actual.send("#{attribute}=", 'x')
    !actual.valid?
  end
  failure_message do |actual|
    actual.errors.full_messages.push(
        "#{actual.class.name} should not be valid without #{attribute.to_s}").join("\n")
  end
end

RSpec::Matchers.define :pass_with_string_at_limit do |attribute, max_length|
  match do |actual|
    actual.send("#{attribute}=", Faker::Lorem.characters(max_length))
    actual.valid?
  end
  failure_message do |actual|
    actual.errors.full_messages.push(
        "#{actual.class.name} should be valid with #{attribute.to_s} at #{max_length}").join("\n")
  end
end

RSpec::Matchers.define :fail_with_string_beyond_limit do |attribute, max_length|
  match do |actual|
    actual.send("#{attribute}=", Faker::Lorem.characters(max_length + 1))
    !actual.valid?
  end
  failure_message do |actual|
    actual.errors.full_messages.push(
        "#{actual.class.name} should not be valid with #{attribute.to_s} longer than #{max_length}").join("\n")
  end
end
