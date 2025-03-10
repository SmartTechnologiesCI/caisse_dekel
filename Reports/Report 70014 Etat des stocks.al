report 70014 "Etat des stocks"
{
    RDLCLayout = 'Reports\RDLC\Report 700014 Etat des stocks.rdlc';
    Caption = 'Etat des stocks par article.';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    // DataAccessIntent = ReadOnly;
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




            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "No." = field("No.");
                column(Shipment_Date; "Shipment Date") { }
                column(Quantity; Quantity) { }
                column(Document_No_; "Document No.") { }
                // column(Nombre_de_carton; "Sales Invoice Line"."Carton effectif") { }
                trigger OnAfterGetRecord()
                var
                    salesInvHeader: Record "Sales Invoice Header";
                begin
                    salesInvHeader.Reset();
                    salesInvHeader.SetRange("No.", "Sales Invoice Line"."Document No.");
                    if salesInvHeader.FindFirst() then begin
                        salesInvHeader.CalcFields(Cancelled);
                        salesInvHeader.SetRange(Cancelled, true);
                        if salesInvHeader.FindFirst() then
                            CurrReport.Skip();
                    end;
                end;

            }


            trigger OnPreDataItem()
            var
                myInt: Integer;
                // item: Record Item;

            begin

                CalcFields(Inventory);
                CalcFields("Cartons Solde");


            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

                CalcFields(Inventory);
                CalcFields("Cartons Solde");
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                salesIvoiceHeader: Record "Sales Invoice Header";
                //silue samuel 07/03/2025 saleIvoiceLine: Record "Sales Invoice Line";

            begin

                salesIvoiceHeader.SetRange("No.", "Sales Invoice Line"."Document No.");
                salesIvoiceHeader.SetRange(CreditP, false);
                if salesIvoiceHeader.FindFirst() then begin
                    repeat begin
                        //salesIvoiceHeader.CalcFields(Cancelled);
                        //if NOT salesIvoiceHeader.Cancelled then begin
                        if "Sales Invoice Line"."No." <> '' then begin
                            "Sales Invoice Line".SetRange("Document No.", salesIvoiceHeader."No.");
                            "Sales Invoice Line".SetRange("Statut Livraison", "Sales Invoice Line"."Statut Livraison"::"Non payée");
                        end;
                        //end else CurrReport.Skip();


                    end until salesIvoiceHeader.Next = 0;
                end;
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
}