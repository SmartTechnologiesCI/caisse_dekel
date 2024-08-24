report 70011 "Palmarès des Fournisseurs"
{
    RDLCLayout = 'Reports\RDLC\Report 70011 Palmarès des Fournisseurs.rdlc';
    Caption = 'Palmarès Fournisseurs';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    // DataAccessIntent = ReadOnly;
    ApplicationArea = Basic, Suite;

    dataset
    {

        dataitem("Vendor"; "Vendor")
        {
            //DataItemLink = "Buy-from Vendor No." = field("No.");
            DataItemTableView = SORTING("No.");

            column(No_; "No.")
            {

            }
            column(Name; "name")
            {

            }
            column(Total_Achat; "Total Achat")
            {

            }
            column(montantCFA; montantCFA) { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                /*                 TotalAmount += "Amount Including VAT";




                                if paramettreComptable.Get() then;

                                if "Currency Code" = '' then
                                    montantCFA := "Purchase Line"."Line Amount"
                                else
                                    if
                            end; "Currency Code" = 'EUR' then
                                        montantCFA := "Purchase Line"."Line Amount" * paramettreComptable."Taux de change Eur - CFA"


                                    else
                                        if "Currency Code" = 'USD' then
                                            montantCFA := "Purchase Line"."Line Amount" * paramettreComptable."Taux de change USD - CFA" */
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //setRange(Type, "Purchase Line".Type::Item);
                //SetRange("Document Type", "Purchase Line"."Document Type"::Order);
                SetFilter("No.", '<>%1', '');
                SetFilter("No.", '<>%1', ' ');
            end;
        }
        /*}*/
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
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        TotalAmount := 0;
    end;

    var
        TotalAmount: Decimal;
        montantCFA: Decimal;
        paramettreComptable: Record 98;
        NoOfRecordsToPrint: Integer;
        MaxAmount: Decimal;
        i: Integer;
}
