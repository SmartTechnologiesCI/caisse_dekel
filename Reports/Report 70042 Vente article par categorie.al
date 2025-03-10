report 70042 "Vente par categorie article"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Reports\RDLC\Report 70042 Vente article par categorie.rdlc';

    dataset
    {
        dataitem("Item Category"; "Item Category")
        {
            column(CodeCatArticle; Code)
            {

            }
            column(Description; Description) { }

            column(somme; somme) { }
            column(SommeTotale; SommeTotale) { }
            column(TitreReport; TitreReport) { }
            column(ChartTypeNo; ChartTypeNo)
            {
            }
            column(CompagnieInfoPicture; CompagnieInfo.Picture) { }
            column(datefilter; datefilter) { }
            column(Date_de_debut; "Date de debut") { }
            column(Date_de_fin; "Date de fin") { }

            trigger OnPreDataItem()
            var
                // EcritComptaArticle2: Record "Item Ledger Entry";
            begin
                // SetFilter("Code", '<>%1', '');
                //
                // EcritComptaArticle2.Reset();
                // EcritComptaArticle2.setrange("Posting Date", "Date de debut", "Date de fin");
                // if EcritComptaArticle2.FindFirst() then begin
                //     repeat
                //         EcritComptaArticle2.CalcFields(EcritComptaArticle2."Sales Amount (Actual)");
                //         SommeTotale += EcritComptaArticle2."Sales Amount (Actual)";
                //     until EcritComptaArticle2.Next() = 0;
                // end;
                // //

            end;

            trigger OnAfterGetRecord()
            var

                // EcritComptaArticle: Record "Item Ledger Entry";


            begin
                ChartTypeNo := ChartType;
                Clear(somme);

                // EcritComptaArticle.Reset();
                // EcritComptaArticle.SetRange("Item Category Code", "Item Category".Code);
                // EcritComptaArticle.setrange("Posting Date", "Date de debut", "Date de fin");

                // if EcritComptaArticle.FindFirst() then begin
                //     repeat

                //         EcritComptaArticle.CalcFields(EcritComptaArticle."Sales Amount (Actual)");
                //         somme += EcritComptaArticle."Sales Amount (Actual)";

                //     until EcritComptaArticle.Next() = 0;

                // end;




            end;

        }


    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Filtre date")
                {

                    field("Date de debut"; "Date de debut") { }
                    field("Date de fin"; "Date de fin") { }

                    field(ChartType; ChartType)
                    {
                        ApplicationArea = All;
                        Caption = 'Chart Type';
                        OptionCaption = 'Diagramme en bâton,Diagramme circulaire';
                        ToolTip = 'Specifies the chart type.';

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {

            }
        }


    }

    trigger OnPreReport()
    var

    begin
        CompagnieInfo.get;
        CompagnieInfo.CalcFields(Picture);
    end;



    var
        myInt: Integer;
        ChartTypeVisible: Boolean;
        ChartType: Option "Bar chart","Pie chart";

        TitreReport: Label 'Ventes articles par catégories';
        datefilter: Text[50];

        "Date de debut": date;
        "Date de fin": date;
        somme: decimal;
        ChartTypeNo: Integer;
        SommeTotale: Decimal;

        CompagnieInfo: Record "Company Information";
}