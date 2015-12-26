//+------------------------------------------------------------------+
//|                                               LicenseManager.mqh |
//|                                          Copyright 2014, Li Ding |
//|                                             http://dingmaotu.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Li Ding"
#property link      "http://dingmaotu.com"
#property strict

#include <ChartObjects\ChartObjectsTxtControls.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AccountLicenseManager
  {
private:
   datetime          m_expired;
   string            m_broker;
   long              m_account;
public:
                     AccountLicenseManager(string broker,long account,datetime expired);
   bool              IsValid();
   bool              IsExpired();

   void              ShowExpirationDate();
   void              RemoveExpirationDate();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
AccountLicenseManager::AccountLicenseManager(string broker,long account,datetime expired)
  {
   m_expired=expired;
   m_broker=broker;
   m_account=account;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AccountLicenseManager::IsValid(void)
  {
   Print("Current broker is ",AccountInfoString(ACCOUNT_COMPANY));
   Print("Current account is ",AccountInfoInteger(ACCOUNT_LOGIN));
   return (AccountInfoString(ACCOUNT_COMPANY) == m_broker) &&
   (AccountInfoInteger(ACCOUNT_LOGIN)==m_account);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AccountLicenseManager::IsExpired(void)
  {
   return TimeCurrent()>=m_expired;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AccountLicenseManager::ShowExpirationDate(void)
  {
   ObjectDelete("ExpirationDateLabel");
   ObjectCreate("ExpirationDateLabel",OBJ_LABEL,0,0,0);
   ObjectSet("ExpirationDateLabel",OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet("ExpirationDateLabel",OBJPROP_XDISTANCE,5);
   ObjectSet("ExpirationDateLabel",OBJPROP_YDISTANCE,20);
   ObjectSet("ExpirationDateLabel",OBJPROP_BACK,True);
   ObjectSetText("ExpirationDateLabel","试用时间截止至："+TimeToStr(m_expired),10,"Times New Roman",Yellow);
/*
   CChartObjectLabel label;
   bool tmp=label.Create(ChartID(),"ExpirationDateLabel",0,5,20);
   if(!tmp)
      Print("Label creation failed: ",GetLastError());
   label.SetString(OBJPROP_TEXT,"试用时间截止至："+TimeToStr(m_expired));
   */
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AccountLicenseManager::RemoveExpirationDate(void)
  {
   ObjectDelete("ExpirationDateLabel");
  }
//+------------------------------------------------------------------+
