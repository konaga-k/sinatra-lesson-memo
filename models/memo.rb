require 'yaml/store'

class Memo
  attr_accessor :id, :title, :content

  def initialize(attributes)
    assign_attributes(attributes)
    # yaml_storeをインスタンス変数にしないと、YAML保存時にnot in transactionエラーになる
    @yaml_store = YAML::Store.new memo_file
  end

  def save
    @yaml_store.transaction do
      @yaml_store['memo'] = self
    end
  end

  def assign_attributes(attributes)
    attributes.each do |k, v|
      public_send(:"#{k}=", v)
    end
  end

  private

  def memo_file
    'data/memo.yml'
  end
end
