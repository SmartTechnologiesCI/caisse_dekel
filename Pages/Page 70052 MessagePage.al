page 70052 "MsgPage"
{
    PageType = HeadlinePart;
    SourceTable = "situation caisse";
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Welcome; welcome)
                {
                    ApplicationArea = All;

                }
                field(Msge; Message)
                {
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        fve: Record "Sales Invoice Header";
                    begin
                        fve.Reset();
                        fve.setfilter("Order Date", '%1..%2', CALCDATE('<CM-1M+1D>', TODAY), CALCDATE('<CM+0D>', TODAY));
                        if (fve.FindFirst()) then begin
                            Page.Run(143, fve);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
         
 
    }

    trigger OnOpenPage()
    var
        dirCue: Record "Director Cue";
        totalMois: Decimal;
        fve: Record "Sales Invoice Header";
        // fin silue samuel 07/03/2025 fveLine: Record "Sales Invoice Line";

        situation: Record "situation caisse";
    begin
        if format(Time) < '12:00:00' then
            Welcome := StrSubstNo(Wlcome, 'Bonjour', UserId())
        else
            if format(Time) > '12:00:00' then
                Welcome := StrSubstNo(Wlcome, 'Bon après midi', UserId())
            else
                if format(Time) > '16:00:00' then
                    Welcome := StrSubstNo(Wlcome, 'Bonsoir', UserId());

        totalMois := 0;
        fve.Reset();
        fve.setfilter("Order Date", '%1..%2', CALCDATE('<CM-1M+1D>', TODAY), CALCDATE('<CM+0D>', TODAY));
        if (fve.FindFirst()) then begin
            repeat
                /*fveLine.Reset();
                fveLine.setRange("Document No.", fve."No.");
                if fveLine.FindFirst() then*/
                fve.CalcFields("Amount Including VAT");
                totalMois += fve."Amount Including VAT";
            until fve.Next = 0;
        end;

        if situation.FindFirst() then
            Message := StrSubstNo(Msg, totalMois);
    end;

    var
        Wlcome: Label '%1 %2';
        Msg: Label '<qualifier>Aperçu du mois</qualifier><payload>Ce mois ci, vous avez vendu <emphasize>%1</emphasize> CFA</payload>';
        welcome: Text;
        Message: Text;
}