# frozen_string_literal: true

# ApplicationRecordは、全てのモデルの基底クラスです。
# 共通のモデルロジックをここに記述します。
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
