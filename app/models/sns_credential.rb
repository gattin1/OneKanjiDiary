# frozen_string_literal: true

# sns認証のモデル
class SnsCredential < ApplicationRecord
  belongs_to :user
end
