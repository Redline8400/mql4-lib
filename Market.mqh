//+------------------------------------------------------------------+
//|                                                       Market.mqh |
//|                                          Copyright 2014, Li Ding |
//|                                             http://dingmaotu.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Li Ding"
#property link      "http://dingmaotu.com"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Market
  {
private:
   string            m_name;

public:
   //-- Constructor
                     Market(string symbol=Symbol())
     {
      m_name=symbol;
     }

   //--- 当前货币对总数
   static int GetTotal() {SymbolsTotal(false);}
   static string GetName(int i) {SymbolName(i,false);}

   static int GetTotalSelected() {SymbolsTotal(true);}
   static string GetNameSelected(int i) {SymbolName(i,true);}

   //-- Basic properties
   string GetName() const {return m_name;}
   void SetName(string symbol) const {m_name=symbol;}
   
   string GetDescription() const {return SymbolInfoString(m_name,SYMBOL_DESCRIPTION);}
   string GetPath() const {return SymbolInfoString(m_name,SYMBOL_PATH);}
   string GetBaseCurrency() const {SymbolInfoString(m_name,SYMBOL_CURRENCY_BASE);}
   string GetProfitCurrency() const {SymbolInfoString(m_name, SYMBOL_CURRENCY_PROFIT);}
   string GetMarginCurrency() const {SymbolInfoString(m_name, SYMBOL_MARGIN_PROFIT);}

   //-- Lot info

   //-- Basic market info

   //-- MarketWatch Ops
   bool Select() {SymbolSelect(m_name, true);}
   bool Remove() {SymbolSelect(m_name, false);}
  }
//+------------------------------------------------------------------+
