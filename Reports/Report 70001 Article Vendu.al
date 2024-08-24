/* report 70002 "Article vendu"
{
    RDLCLayout = 'Reports\RDLC\Report 70002 Articles vendu.rdlc';
    Caption = 'Listes des articles vendu du jour';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            //RequestFilterFields = "order date";
            column(No_; "No.")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(CurrDateStart; CurrDateStart)
            {

            }
            column(CurrDateEnd; CurrDateEnd)
            {

            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Item_No_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Nombre_de_carton; "Nombre de carton")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("Order Date", CurrDateStart, CurrDateEnd);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

                field(CurrDateStart; CurrDateStart)
                {
                    Caption = 'Date Début';
                }
                field(CurrDateEnd; CurrDateEnd)
                {
                    Caption = 'Date Fin';
                }
            }
        }

        actions
        {

        }
        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            CurrDateStart := WorkDate();
            CurrDateEnd := WorkDate();
        end;
    }
    var

        CurrDateStart: Date;
        CurrDateEnd: Date;
} */