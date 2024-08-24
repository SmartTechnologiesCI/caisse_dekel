report 70016 "Etat de control livraison"
{
    RDLCLayout = 'Reports\RDLC\Report 70016 Etat de control livraison.rdlc';
    Caption = 'Etat de control des livraisons';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DataAccessIntent = ReadOnly;
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem(Item; Item)
        {
            /*  column(ColumnName; SourceFieldName)
             {
                 DataItemLink = "Document No." = field("No.");
             } */

            RequestFilterFields = "No.";


            column(No_; "No.") { }
            column(Inventory; Inventory) { }
            column(Carton_en_stock; Item."Cartons Solde") { }
            column(Description; Description) { }
            column(Unit_price; Unit_price) { }


            trigger OnPreDataItem()
            var
                myInt: Integer;
                item: Record Item;


            begin




            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;


            begin

                /* item.SetRange("No.", SalesInvoiceLine."No.");
                Unit_price := SalesInvoiceLine."Unit Price"; */
                SalesInvoiceLine.SetRange("No.", "No.");


                if SalesInvoiceLine.FindFirst() then begin
                    Unit_price := SalesInvoiceLine."Unit Price";
                end;
                //Skip tout  les produits sans stock
                if Item.Inventory <= 0 then begin
                    CurrReport.Skip();
                end;
                if Item."Cartons Solde" <= 0 then
                    CurrReport.Skip();






            end;



        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
        Unit_price: Integer;
        SalesInvoiceLine: Record "Sales Invoice Line";
}