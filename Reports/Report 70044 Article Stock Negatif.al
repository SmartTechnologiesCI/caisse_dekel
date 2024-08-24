/// <summary>
/// Report evnement stock (ID 70049).
/// </summary>
report 70044 "Article Stock Negatif "
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Reports\RDLC\Report 70044 Article Stock Negatif.rdlc';
    Caption = 'evenement stock';

    dataset
    {
        dataitem(Item; Item)
        {
            column(NameSociety; companyInfo.Name)
            {

            }
            column(ImageCompany; companyInfo.Picture)
            {

            }
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {

            }
            column("NbrCarton__calculé"; "NbrCarton__calculé")
            {

            }
            column(Nombre_cartons; "Nombre cartons")
            {

            }
            column("Poids_calculé"; "Poids_calculé")
            {

            }
            column(Poids; Poids)
            {

            }
            column(Inventory; Inventory)
            {

            }
            column(Cartons_Solde; "Cartons Solde")
            {

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Item.Reset();
                Item.SetRange(Blocked, false);
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // field(DateDebutFilter; DateDebutFilter)
                // {
                //     Caption = 'Date debut';
                // }
                // field(DateFinFlter; DateFinFlter)
                // {
                //     Caption = 'Date Fin';
                // }

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
        companyInfo.Get();
        companyInfo.CalcFields(Picture)
    end;

    var
        myInt: Integer;
        Poids_calculé: Decimal;
        DateDebutFilter: Date;
        DateFinFlter: Date;
        NbrCarton__calculé: Decimal;
        companyInfo: Record "Company Information";
        ItemVipa: Record Item;

}