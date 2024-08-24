page 70025 "Liste Billets"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Billetage;

    layout
    {
        area(Content)
        {
            group(Billet)
            {
                CaptionML = ENU = 'Banknotes', FRA = 'Billetage';
                repeater(money)
                {
                    field("Code Billet"; "Code Billet")
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Code', FRA = 'Code';
                    }
                    field("Nom Billet"; "Nom Billet")
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Name', FRA = 'Nom';
                    }
                    field(Valeur; Valeur)
                    {
                        CaptionML = ENU = 'Value', FRA = 'Valeur';
                        ApplicationArea = All;
                    }
                }

            }
        }
    }


}