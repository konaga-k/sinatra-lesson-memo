require 'yaml/store'

class Memo
  attr_accessor :id, :title, :content

  class << self
    def all(ordered: false)
      memos = YAML.load_file(memo_file_path)[resource_name]
      memos.sort_by(&:id) if ordered
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
      yaml_store[resource_name].delete_if { |memo| memo.id.to_i == id.to_i }
      yaml_store[resource_name] = Array(yaml_store[resource_name]).push(self)
    end
  end

  def delete
    yaml_store = YAML::Store.new(memo_file_path)
    yaml_store.transaction do
      yaml_store[resource_name].delete_if { |memo| memo.id.to_i == id.to_i }
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

  def assign_attribute(k, v)
    public_send(:"#{k}=", v)
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
