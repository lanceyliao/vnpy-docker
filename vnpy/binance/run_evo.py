from time import sleep

from vnpy_evo.event import EventEngine
from vnpy_evo.trader.engine import MainEngine
from vnpy_evo.trader.ui import MainWindow, create_qapp
from vnpy_evo.trader.utility import load_json
from vnpy_ctastrategy import CtaStrategyApp

# from vnpy_binance import (
#     BinanceSpotGateway,
#     BinanceLinearGateway,
#     BinanceInverseGateway
# )
from prod.binance_linear_gateway import BinanceLinearGateway
from vnpy_ctastrategy.base import EVENT_CTA_LOG
# from vnpy_riskmanager import RiskManagerApp

def main():
    """主入口函数"""
    qapp = create_qapp()

    event_engine = EventEngine()
    main_engine = MainEngine(event_engine)
    # main_engine.add_gateway(BinanceSpotGateway)
    main_engine.add_gateway(BinanceLinearGateway)
    # main_engine.add_gateway(BinanceInverseGateway)

    # risk_engine = main_engine.add_app(RiskManagerApp)

    main_window = MainWindow(main_engine, event_engine)
    main_window.showMaximized()
    
    qapp.exec()

    # 新增部分

    # cta_engine = main_engine.add_app(CtaStrategyApp)

    # log_engine = main_engine.get_engine("log")
    # event_engine.register(EVENT_CTA_LOG, log_engine.process_log_event)

    # email_engine = main_engine.get_engine("email")

    # connect_filename = 'connect_binance_moni_lb.json'
    # setting = load_json(connect_filename)
    # # # main_engine.connect(setting, "BINANCE_SPOT")
    # main_engine.connect(setting, "BINANCE_LINEAR")
    # # main_engine.connect(setting, "BINANCE_INVERSE")
    # main_engine.write_log("连接BINANCE接口")

    # sleep(10)
    # main_engine.write_log("***查询资金和持仓***")
    # # 查询资金 - 自动
    # main_engine.write_log(main_engine.get_all_accounts())
    # # 查询持仓
    # main_engine.write_log(main_engine.get_all_positions())
    # # 查询合约信息
    # main_engine.write_log(main_engine.get_all_contracts())

    # cta_engine.init_engine()# 此时会将strategy_setting中的策略add_strategy
    # main_engine.write_log("CTA引擎初始化完成")


if __name__ == "__main__":
    main()
