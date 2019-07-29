clear all;
clc;
gamma_th=5;
gamma_th_abs=10.^(5/10);
R=1;
Ip=9;
Ip_abs=10.^(9/10);
lambda_RE=9;
abs_RE=10.^(9/10);
lambda_SE=3;
abs_SE=10.^(3/10);
lambda_SD=6;
abs_SD=10.^(6/10);
lambda_SP=3;
abs_SP=10.^(3/10);
lambda_RP=3;
abs_RP=10.^(3/10); 
SOP_it=1;
for N=1:4
    for lambda=0:5:30 
        lambda_SK=lambda;
        abs_SK=10.^(lambda/10);
        lambda_KD=lambda;
        abs_KD=10.^(lambda/10);
        count_dec_set_empty=0;
        count_sop_emptyset=0;
        K_1_count_sop_emptyset=0;
        K_2_count_sop_emptyset=0;
        K_3_count_sop_emptyset=0;
        K_4_count_sop_emptyset=0;
        K_1_count_dec_empty=0;
        K_2_count_dec_empty=0;
        K_3_count_dec_empty=0;
        K_4_count_dec_empty=0;
        no_of_it=100000;
        count_cardinality=0;
        count_Rs=0;
        for it=1:no_of_it
            
            channel_SD=sqrt(abs_SD).*abs(sqrt(0.5)*(randn(1)+i*randn(1)));
            channel_SP=sqrt(abs_SP).*abs(sqrt(0.5)*(randn(1)+i*randn(1)));
            channel_SE=sqrt(abs_SE).*abs(sqrt(0.5)*(randn(1)+i*randn(1)));
            for N_it=1:N
            channel_SK(1,N_it)=sqrt(abs_SK).*abs(sqrt(0.5)*(randn(1)+i*randn(1)));
            channel_KD(N_it,1)=sqrt(abs_KD).*abs(sqrt(0.5)*(randn(1)+i*randn(1)));
            channel_RP(N_it,1)=sqrt(abs_RP).*abs(sqrt(0.5)*(randn(1)+i*randn(1)));
            channel_RE(N_it,1)=sqrt(abs_RE).*abs(sqrt(0.5)*(randn(1)+i*randn(1)));
            end
            cardinality=0;
            set_K=[];
            for no_relay=1:N
                if (channel_SK(1,no_relay).^2) >=gamma_th_abs
                    cardinality=cardinality+1;
                    set_K(1,cardinality)=no_relay;
                end
            end
            temp=-1;
            if cardinality>0
                for i=1:cardinality
                    if channel_KD(set_K(i),1).^2 > temp
                        temp=(channel_KD(set_K(i),1)).^2;
                        maxindex=set_K(i);
                    end
                    
                end
            else
                maxindex=-1;
            end
            
            if cardinality>=1
                Rs_part1=0.5 * log2(1+ (Ip_abs*( channel_KD(maxindex,1).^2 ) /( channel_RP(maxindex,1).^2 ) ) + (Ip_abs*(channel_SD.^2)/(channel_SP.^2)));
                Rs_part2=0.5* log2(1+(Ip_abs*( channel_RE(maxindex,1).^2 ) /( channel_RP(maxindex,1).^2 ) ) + ( Ip_abs*(channel_SE.^2)/(channel_SP.^2)));
                Rs=max(0,Rs_part1-Rs_part2);
                count_Rs=1+count_Rs;
            else
                Rs_temp=0.5*log2( 1+( Ip_abs * (channel_SD.^2)/(channel_SP.^2) ) )-(0.5*log2( 1+( Ip_abs* (channel_SE.^2)/(channel_SP.^2) )));
                Rs=max(0,Rs_temp);
            end
            
            if cardinality==0
                count_dec_set_empty=count_dec_set_empty+1;
                if Rs<R
                    count_sop_emptyset=count_sop_emptyset+1;
                end
            end
            
            if cardinality==1
                K_1_count_dec_empty=K_1_count_dec_empty+1;
                if Rs<R
                    K_1_count_sop_emptyset=K_1_count_sop_emptyset+1;
                end
            end
            
            if cardinality==2
                K_2_count_dec_empty=K_2_count_dec_empty+1;
                if Rs<R
                    K_2_count_sop_emptyset=K_2_count_sop_emptyset+1;
                end
            end
            
            if cardinality==3
                K_3_count_dec_empty=K_3_count_dec_empty+1;
                if Rs<R
                    K_3_count_sop_emptyset=K_3_count_sop_emptyset+1;
                end
            end
            
            if cardinality==4
                K_4_count_dec_empty=K_4_count_dec_empty+1;
                if Rs<R
                    K_4_count_sop_emptyset=K_4_count_sop_emptyset+1;
                end
            end
        end
        Pr_1=count_dec_set_empty/no_of_it*(count_sop_emptyset/no_of_it);
        Pr_K_1=K_1_count_dec_empty/no_of_it*(K_1_count_sop_emptyset/no_of_it);
        Pr_K_2=K_2_count_dec_empty/no_of_it*(K_2_count_sop_emptyset/no_of_it);
        Pr_K_3=K_3_count_dec_empty/no_of_it*(K_3_count_sop_emptyset/no_of_it);
        Pr_K_4=K_4_count_dec_empty/no_of_it*(K_4_count_sop_emptyset/no_of_it);
        if N==1
            SOP_val(SOP_it)=Pr_1+Pr_K_1;
            SOP_it=SOP_it+1;
            
        elseif N==2
            SOP_val(SOP_it)=Pr_1+Pr_K_1+Pr_K_2;
            SOP_it=SOP_it+1;
            
        elseif N==3 
            SOP_val(SOP_it)=Pr_1+Pr_K_1+Pr_K_2+Pr_K_3;
            SOP_it=SOP_it+1;
            
        elseif N==4 
            SOP_val(SOP_it)=Pr_1+Pr_K_1+Pr_K_3+Pr_K_4;
            SOP_it=SOP_it+1;
            
        end
            
    end
end
save SOP.mat
