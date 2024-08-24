/// <summary>
/// Report evnement stock (ID 70049).
/// </summary>
report 70047 "Facture Valide"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Reports\RDLC\Report 70047 Facture Valide.rdlc';
    Caption = 'Facture Valide';

    dataset
    {
        dataitem("G/L Entry";"G/L Entry")
        {
            column(NameSociety; companyInfo.Name)
            {

            }
            column(ImageCompany; companyInfo.Picture)
            {

            }
            column(Document_Type;"Document Type")
            {

            }
            column(Document_No_;"Document No.")
            {

            }
            column(Description;Description)
            {

            }
            column(Amount;Amount)
            {

            }
            column(Document_Date;"Document Date"){

            }
            // column("Poids_calculé"; "Poids_calculé")
            // {

            // }
            // column(Poids; Poids)
            // {

            // }
            // column(Inventory; Inventory)
            // {

            // }
            // column(Cartons_Solde; "Cartons Solde")
            // {

            // }
            trigger OnPreDataItem()
            var

            begin
                "G/L Entry".Reset();
                "G/L Entry".SetRange("Document Type",2);
                "G/L Entry".SetRange("Document Date",DateDebutFilter);
                
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(DateDebutFilter; DateDebutFilter)
                {
                    Caption = 'Date validation';
                }
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