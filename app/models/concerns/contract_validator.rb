class ContractValidator < ActiveModel::Validator

  def validate(record)
    return unless record.ends_on.present? && record.starts_on.present?
    if record.ends_on < record.starts_on
      record.errors[:base] << "Ends on should be greater than Starts on"
    end
  end
end
