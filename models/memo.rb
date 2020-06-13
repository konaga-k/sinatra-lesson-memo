# frozen_string_literal: true

require 'yaml/store'

class Memo
  attr_accessor :id, :title, :content

  class << self
    def all(ordered: false)
      yaml_data = YAML.load_file(memo_file_path)
      return [] unless yaml_data

      memos = yaml_data[resource_name]
      ordered ? memos.sort_by(&:id) : memos
    end

    def find(id)
      all.find { |memo| memo.id.to_i == id.to_i }
    end
  end

  def initialize(attributes)
    assign_attributes(attributes)
  end

  def save
    set_new_id if id.nil?

    yaml_store = YAML::Store.new(memo_file_path)
    yaml_store.transaction do
      yaml_store[resource_name]&.delete_if { |memo| memo.id.to_i == id.to_i }
      yaml_store[resource_name] = Array(yaml_store[resource_name]).push(self)
    end
  end

  def delete
    yaml_store = YAML::Store.new(memo_file_path)
    yaml_store.transaction do
      yaml_store[resource_name]&.delete_if { |memo| memo.id.to_i == id.to_i }
    end
  end

  def assign_attributes(attributes)
    attributes.each do |k, v|
      assign_attribute(k, v)
    end
  end

  private

  class << self
    def memo_file_path
      'data/memo.yml'
    end

    def resource_name
      'memo'
    end
  end

  def memo_file_path
    self.class.memo_file_path
  end

  def resource_name
    self.class.resource_name
  end

  def assign_attribute(key, value)
    public_send(:"#{key}=", value)
  end

  def set_new_id
    sequence_file_path = 'data/memo_sequence'

    new_id = File.read(sequence_file_path).chomp.to_i
    self.id = new_id

    # TODO: saveが失敗したらこの書き込みはロールバックされないといけない
    # 簡易アプリなので手抜き中
    File.open(sequence_file_path, 'w') do |f|
      f.write(new_id + 1)
    end
  end
end
