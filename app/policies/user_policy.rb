class UserPolicy < ApplicationPolicy
  def new?
    true
  end

  def show?
    user == record || record.is_published
  end

  def create?
    true
  end

  def edit?
    user == record
  end

  def update?
    user == record
  end

  def destroy?
    user == record
  end
end
