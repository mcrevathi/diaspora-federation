require 'spec_helper'

describe Validation::Rule::Guid do
  it 'will not accept parameters' do
    v = Validation::Validator.new({})
    expect {
      v.rule(:guid, guid: { param: true })
    }.to raise_error
  end

  context 'validation' do
    it 'validates a string at least 16 chars long, consisting of [0-9a-f]' do
      v = Validation::Validator.new(OpenStruct.new(guid: 'abcdef0123456789'))
      v.rule(:guid, :guid)

      v.should be_valid
      v.errors.should be_empty
    end
  end

  it 'fails if the string is too short' do
    v = Validation::Validator.new(OpenStruct.new(guid: '012345'))
    v.rule(:guid, :guid)

    v.should_not be_valid
    v.errors.should include(:guid)
  end

  it 'fails if the string contains invalid chars' do
    v = Validation::Validator.new(OpenStruct.new(guid: 'ghijklmnopqrstuvwxyz++'))
    v.rule(:guid, :guid)

    v.should_not be_valid
    v.errors.should include(:guid)
  end

  it 'fails if the string is empty' do
    v = Validation::Validator.new(OpenStruct.new(guid: ''))
    v.rule(:guid, :guid)

    v.should_not be_valid
    v.errors.should include(:guid)
  end
end
