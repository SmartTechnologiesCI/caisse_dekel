report 70022 "Performance Preparateur"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Performance peseur';
    RDLCLayout = 'Reports\RDLC\Report 70022 Performance peseur.rdlc';

    dataset
    {
        dataitem(Peseur; Peseur)
        {
            PrintOnlyIfDetail = true;

            column(Code_Peseur; "Code Peseur") { }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                RequestFilterFields = "Posting Date";

                column(Document_No_; "Document No.") { }
                column(Line_No_; "Line No.") { }
                column(No_; "No.") { }
                // silue samuel 07/03/2025 column(Carton_effectif; "Carton effectif") { }
                column(Quantity; Quantity) { }
                column(HideLines; HideLines) { }
                column(Line_Filters; "Sales Invoice Line".GetFilters()) { }

                trigger OnAfterGetRecord()
                var
                    salesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    if ((Preparateur <> Peseur."Code Peseur") and (Verificateur <> Peseur."Code Peseur")) then begin
                        CurrReport.Skip();
                    end else begin
                        salesInvoiceHeader.Reset();
                        salesInvoiceHeader.SetRange("No.", "Sales Invoice Line"."Document No.");

                        if salesInvoiceHeader.FindFirst() then begin
                            if salesInvoiceHeader.Cancelled = true then begin
                                CurrReport.Skip();
                            end;
                        end;
                    end;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(HideLines; HideLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Masquer les lignes';
                    }
                }
            }
        }
    }

    var
        HideLines: Boolean;
}