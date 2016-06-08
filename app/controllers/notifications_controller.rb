class NotificationsController < ApplicationController
  def index
    skip_authorization
    feed = Feed.for_user(
      current_user,
      params[:filter],
      params[:category] || :all,
      params[:page] || 1,
      params[:count] || 25
    )

    render json: PaginatedCollectionPresenter.new(
      feed.notifications,
      request,
      NotificationPresenter,
      PaginationPresenter,
      { upto: feed.upto }
    )
  end

  def update
    seen_status = params[:seen]
    query = if (notification_ids = params[:notification_ids]).present?
                      Notification.where(id: notification_ids, seen: !seen_status)
                    elsif (upto = params[:upto]).present?
                      Notification.where(notified_user: current_user, seen: !seen_status).where('created_at <= ?', upto)
                    end

    count = query.count
    notifications = query.page(1).per(count)
    if notifications.any?
      notifications.each do |n|
        authorize n
        n.seen = seen_status
        n.save
      end

      render json: PaginatedCollectionPresenter.new(
        notifications,
        request,
        NotificationPresenter,
        PaginationPresenter,
        { upto: notifications.map(&:created_at).max }
      )
    else
      skip_authorization
      render json: { errors: [ 'Must specify either notification_ids or an upto time!'] }, status: :bad_request
    end
  end
end