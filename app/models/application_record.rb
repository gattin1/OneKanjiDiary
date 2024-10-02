# frozen_string_literal: true

# ApplicationRecordは、全てのモデルの基底クラス
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
