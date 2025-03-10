report 70017 "Etat des factures douanires"
{
    RDLCLayout = 'Reports\RDLC\Report 70017 Etat des factures douanieres.rdlc';
    Caption = 'Etat des factures douanieres';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    DataAccessIntent = ReadOnly;
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {

            // RequestFilterFields = "Document Date","Contrat origine";

            column(No_; "No.") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(Due_Date; "Due Date") { }
            column(Document_Date; "Document Date") { }
            // column(Contrat_origine; "Contrat origine") { }

            dataitem ("Sales Invoice Line";"Sales Invoice Line"){
                DataItemLink = "Document No." = field("No.");
                column(itemNo;"No."){}
                column(Description;Description){

                }
                column(Description_2;"Description 2"){

                }
                column(Quantity;Quantity){}
                
            }



            trigger OnPreDataItem()
            var
            begin
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;


            begin

                if "Sales Invoice Header"."Est Echantillone" = false then
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
       
}