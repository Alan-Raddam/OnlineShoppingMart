module TransactionOrdersHelper

  def get_paid_status transaction_order
    get_paid_status_by_id transaction_order.sstatus
  end

  def get_paid_status_by_id id
    if id == 0
      return "待付款"
    end
    if id == 1
      return "已支付"
    end
    if id == 2
      return "已发货"
    end
    if id == 3
      return "已取消"
    end
    if id == 4
      return "已完成"
    end
    if id == 5
      return "已退款"
    end
  end
end
