//+------------------------------------------------------------------+
//|                                               Trade/FxSymbol.mqh |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014-2016, Li Ding"
#property link      "dingmaotu@hotmail.com"
#property strict

#include "Utils.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FxSymbol
  {
private:
   string            m_symbol;

public:
   //-- Constructor
                     FxSymbol(string symbol=""):m_symbol(symbol==""?Symbol():symbol){}

   //--- SymbolWatch
   static int        getTotal() {return SymbolsTotal(false);}
   static string     getName(int i) {return SymbolName(i,false);}

   static int        getTotalSelected() {return SymbolsTotal(true);}
   static string     getNameSelected(int i) {return SymbolName(i,true);}

   bool              select() {return SymbolSelect(m_symbol, true);}
   bool              remove() {return SymbolSelect(m_symbol, false);}

   bool              isSelected() {return SymbolInfoInteger(m_symbol,SYMBOL_SELECT)!=0;}
   bool              isVisible() {return SymbolInfoInteger(m_symbol,SYMBOL_VISIBLE)!=0;}

   //-- basic properties
   string            getName() const {return m_symbol;}
   void              setName(string symbol) {m_symbol=symbol;}

   //-- symbol info
   string            getDescription() const {return SymbolInfoString(m_symbol,SYMBOL_DESCRIPTION);}
   string            getPath() const {return SymbolInfoString(m_symbol,SYMBOL_PATH);}
   string            getBaseCurrency() const {return SymbolInfoString(m_symbol,SYMBOL_CURRENCY_BASE);}
   string            getProfitCurrency() const {return SymbolInfoString(m_symbol,SYMBOL_CURRENCY_PROFIT);}
   string            getMarginCurrency() const {return SymbolInfoString(m_symbol,SYMBOL_CURRENCY_MARGIN);}

   //-- trade mode
   ENUM_SYMBOL_TRADE_MODE getTradeMode() const {return(ENUM_SYMBOL_TRADE_MODE)SymbolInfoInteger(m_symbol,SYMBOL_TRADE_MODE);}
   bool              isTradeDisabled() const {return getTradeMode()==SYMBOL_TRADE_MODE_DISABLED;}
   bool              isTradeFully() const {return getTradeMode()==SYMBOL_TRADE_MODE_FULL;}
   bool              isTradeShortOnly() const {return getTradeMode()==SYMBOL_TRADE_MODE_SHORTONLY;}
   bool              isTradeLongOnly() const {return getTradeMode()==SYMBOL_TRADE_MODE_LONGONLY;}
   bool              isTradeCloseOnly() const {return getTradeMode()==SYMBOL_TRADE_MODE_CLOSEONLY;}

   double            getInitialMargin() const {return SymbolInfoDouble(m_symbol,SYMBOL_MARGIN_INITIAL);}
   double            getMaintenanceMargin() const {return SymbolInfoDouble(m_symbol,SYMBOL_MARGIN_MAINTENANCE);}
   double            getLongSwap() const {return SymbolInfoDouble(m_symbol,SYMBOL_SWAP_LONG);}
   double            getShortSwap() const {return SymbolInfoDouble(m_symbol,SYMBOL_SWAP_SHORT);}
   //-- latest market info
   double            getBid() const {return SymbolInfoDouble(m_symbol,SYMBOL_BID);}
   double            getAsk() const {return SymbolInfoDouble(m_symbol,SYMBOL_ASK);}
   bool              getTick(MqlTick &tick) const {return SymbolInfoTick(m_symbol,tick);}

   double            getTickSize() const {return SymbolInfoDouble(m_symbol,SYMBOL_TRADE_TICK_SIZE);}
   double            getTickValue() const {return SymbolInfoDouble(m_symbol,SYMBOL_TRADE_TICK_VALUE);}

   double            getContractSize() const {return SymbolInfoDouble(m_symbol,SYMBOL_TRADE_CONTRACT_SIZE);}

   //-- basic trade info
   double            getPoint() const {return SymbolInfoDouble(m_symbol,SYMBOL_POINT);}
   int               getDigits() const {return (int)SymbolInfoInteger(m_symbol,SYMBOL_DIGITS);}
   int               getSpread() const {return (int)SymbolInfoInteger(m_symbol,SYMBOL_SPREAD);}
   bool              isSpreadFloat() const {return SymbolInfoInteger(m_symbol,SYMBOL_SPREAD_FLOAT)!=0;};
   int               getStopLevel() const {return(int)SymbolInfoInteger(m_symbol,SYMBOL_TRADE_STOPS_LEVEL);}
   int               getFreezeLevel() const {return(int)SymbolInfoInteger(m_symbol,SYMBOL_TRADE_FREEZE_LEVEL);}

   //-- lot info
   double            getMinLot() const {return SymbolInfoDouble(m_symbol,SYMBOL_VOLUME_MIN);}
   double            getLotStep() const {return SymbolInfoDouble(m_symbol,SYMBOL_VOLUME_STEP);}
   double            getMaxLot() const {return SymbolInfoDouble(m_symbol,SYMBOL_VOLUME_MAX);}

   //-- utility methods
   double            normalizeLots(double lots) const {return NormalizeLots(lots,getMinLot());}
   double            normalizePrice(double price) const {return NormalizeDouble(price,getDigits());}

   double            addPoints(double price,int points) const {return points > 0 ? NormalizeDouble(price+points*getPoint(),getDigits()) : price;}
   double            subPoints(double price,int points) const {return points > 0 ? NormalizeDouble(price-points*getPoint(),getDigits()) : price;}

   double            priceForOpen(int op) const {return op==OP_BUY?getAsk():getBid();}
   double            priceForClose(int op) const {return op==OP_BUY?getBid():getAsk();}
  };
//+------------------------------------------------------------------+
