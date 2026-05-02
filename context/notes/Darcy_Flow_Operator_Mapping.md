# 다르시 유동 솔루션 매핑: Green 함수와 푸리에 변환의 결합

본 문서는 다공성 매질 내의 유체 흐름을 나타내는 **다르시 유동(Darcy Flow)** 문제를 수학적 연산자(Operator) 관점에서 어떻게 정의하고, **그린 함수(Green's Function)**와 **푸리에 변환(Fourier Transform)**을 결합하여 함수 형태의 입력(Input)을 함수 형태의 출력(Output, 솔루션)으로 매핑하는지 그 전체 흐름과 유도 과정을 상세히 다룹니다.

---

## 1. 문제의 정의: 지배 방정식 (Governing Equation)

다르시 유동은 질량 보존(연속 방정식)과 운동량 보존(다르시의 법칙)이 결합되어 형성됩니다.

* **연속 방정식 (질량 보존):** $\nabla \cdot \mathbf{v}(\mathbf{x}) = f(\mathbf{x})$
* **다르시의 법칙:** $\mathbf{v}(\mathbf{x}) = -K(\mathbf{x}) \nabla p(\mathbf{x})$

두 식을 결합하면 다음과 같은 2계 편미분 방정식(PDE)이 도출됩니다.

$$-\nabla \cdot (K(\mathbf{x}) \nabla p(\mathbf{x})) = f(\mathbf{x})$$

* $\mathbf{x}$: 공간 좌표
* $K(\mathbf{x})$: 투과도(Permeability)에 유체의 점성을 나눈 이동도 (입력 파라미터)
* $p(\mathbf{x})$: 압력 분포 (우리가 구하고자 하는 출력 솔루션)
* $f(\mathbf{x})$: 소스/싱크 (예: 우물의 주입/생산량)

**목표:** 이 시스템은 본질적으로 투과도장 $K$와 소스장 $f$라는 **'입력 함수'**를 받아, 압력장 $p$라는 **'출력 함수'**를 내뱉는 거대한 연산자 $\mathcal{G}$로 볼 수 있습니다. 즉, $p = \mathcal{G}(K, f)$ 의 관계를 푸는 것입니다.

---

## 2. 매질 균질화 가정과 포아송 방정식

수학적 유도의 직관성을 위해, 공간에 따라 요동치는 투과도 $K(\mathbf{x})$를 전체 공간에서 일정한 상수 $K$로 가정해 보겠습니다. (불균질 매질의 처리는 나중에 AI 연산자로 확장됩니다.)

$K$가 상수라면 식 밖으로 빠져나올 수 있으며, 지배 방정식은 포아송 방정식(Poisson's equation)으로 단순화됩니다.

$$-K \nabla^2 p(\mathbf{x}) = f(\mathbf{x})$$

여기서 $\nabla^2$는 라플라시안(Laplacian) 연산자입니다.

---

## 3. Green 함수를 이용한 공간 도메인에서의 매핑

이 복잡한 미분 방정식을 적분 형태로 풀기 위해 **그린 함수(Green's Function, $G$)**를 도입합니다. 그린 함수는 시스템에 **점 소스(디랙 델타 함수, $\delta$)**가 주어졌을 때의 기본 응답(Impulse response)을 의미합니다.

### 3.1 Green 함수의 정의
$$-K \nabla^2 G(\mathbf{x}, \mathbf{x}') = \delta(\mathbf{x} - \mathbf{x}')$$

이 수식은 "위치 $\mathbf{x}'$에 단 한 방울의 유체를 주입했을 때, 공간 $\mathbf{x}$로 퍼져나가는 압력의 형태"를 의미합니다.

### 3.2 중첩의 원리 (Superposition) 및 적분 해 유도
실제 소스 $f(\mathbf{x})$는 무수히 많은 점 소스들의 합으로 볼 수 있습니다. 선형 시스템의 특성에 따라, 전체 압력 $p(\mathbf{x})$는 각각의 점 소스에 대한 응답(Green 함수)들을 모두 더한(적분한) 것과 같습니다.

$$p(\mathbf{x}) = \int_{\Omega} G(\mathbf{x}, \mathbf{x}') f(\mathbf{x}') d\mathbf{x}'$$

이 식은 수학적으로 **합성곱(Convolution, $*$)**의 형태를 띱니다.

$$p(\mathbf{x}) = (G * f)(\mathbf{x})$$

**💡 공간 도메인 매핑의 의미:** 미분 연산자($\nabla^2$)를 푸는 어려운 문제가, 그린 함수 $G$를 이용해 입력 함수 $f$를 한 점씩 훑고 지나가며 곱하고 더하는 **합성곱(Convolution) 연산**으로 바뀌었습니다. 입력 함수 $f$가 출력 함수 $p$로 성공적으로 매핑되었습니다.

---

## 4. 푸리에 변환을 이용한 해법 (연산의 효율성 극대화)

그린 함수를 이용한 매핑은 수학적으로 아름답지만, 컴퓨터로 무한한 공간을 적분(합성곱)하는 것은 계산 비용이 천문학적입니다. 이를 타개하기 위해 **푸리에 변환(Fourier Transform, $\mathcal{F}$)**을 도입합니다.

### 4.1 주파수 도메인으로의 변환
공간 변수 $\mathbf{x}$를 주파수 변수 $\mathbf{\omega}$로 변환합니다. 푸리에 변환의 마법은 공간에서의 미분($\nabla$)을 주파수 도메인에서의 단순 곱셈($i\mathbf{\omega}$)으로 바꿔준다는 것입니다.

$$\mathcal{F} \{ \nabla^2 p(\mathbf{x}) \} = -|\mathbf{\omega}|^2 \hat{p}(\mathbf{\omega})$$

이를 원래의 편미분 방정식 $-K \nabla^2 p(\mathbf{x}) = f(\mathbf{x})$ 에 적용하여 양변을 푸리에 변환합니다.

$$K |\mathbf{\omega}|^2 \hat{p}(\mathbf{\omega}) = \hat{f}(\mathbf{\omega})$$

### 4.2 대수 방정식 풀이 및 $\hat{G}$ 도출
미분 방정식이 단순히 $\hat{p}(\mathbf{\omega})$에 대한 초등학교 수준의 1차 방정식으로 변했습니다! 이를 $\hat{p}(\mathbf{\omega})$에 대해 정리합니다.

$$\hat{p}(\mathbf{\omega}) = \frac{1}{K |\mathbf{\omega}|^2} \hat{f}(\mathbf{\omega})$$

여기서 곱해진 $\frac{1}{K |\mathbf{\omega}|^2}$ 항을 잘 살펴보면, 이것이 바로 **그린 함수 $G(\mathbf{x})$를 푸리에 변환한 $\hat{G}(\mathbf{\omega})$**와 완벽히 일치합니다.

즉, 주파수 도메인에서는 다음이 성립합니다.
$$\hat{p}(\mathbf{\omega}) = \hat{G}(\mathbf{\omega}) \cdot \hat{f}(\mathbf{\omega})$$

이는 공간 도메인에서의 합성곱 $p = G * f$ 가 주파수 도메인에서는 **단순 요소별 곱셈(Element-wise multiplication)**으로 바뀐다는 **합성곱 정리(Convolution Theorem)**를 정확히 증명합니다.

### 4.3 역변환을 통한 최종 매핑
이제 구한 $\hat{p}(\mathbf{\omega})$를 다시 **역 푸리에 변환(Inverse Fourier Transform, $\mathcal{F}^{-1}$)** 하여 원래의 공간 도메인 해를 얻습니다.

$$p(\mathbf{x}) = \mathcal{F}^{-1} \{ \hat{G}(\mathbf{\omega}) \cdot \mathcal{F} \{ f(\mathbf{x}) \} \}$$

---

## 5. 최종 요약 및 현대 AI(FNO)로의 연결

지금까지의 수학적 흐름을 단 한 줄의 '연산자 파이프라인'으로 요약하면 다음과 같습니다.

1. **입력 함수 변환:** 복잡한 소스 분포 $f(\mathbf{x})$를 푸리에 변환하여 $\hat{f}(\mathbf{\omega})$로 만듭니다.
2. **필터링 (그린 함수 곱셈):** 시스템의 본질적 특성인 그린 함수 $\hat{G}(\mathbf{\omega})$를 곱합니다. (미분이 단순 곱셈으로 해결됨)
3. **출력 함수 생성:** 역변환 $\mathcal{F}^{-1}$을 수행하여 최종 압력 분포 $p(\mathbf{x})$를 얻어냅니다.

**💡 현대 딥러닝과의 연결고리:**
현실의 지층은 $K$가 상수가 아니라 $K(\mathbf{x})$처럼 불균질하여, 푸리에 공간에서 완벽한 선형 곱셈으로 떨어지지 않습니다. 

최근 전산유체역학의 혁명을 일으킨 **푸리에 신경망 연산자(Fourier Neural Operator, FNO)**는 바로 이 지점에서 탄생했습니다. FNO는 해석적으로 구하기 불가능한 불균질 매질의 복잡한 $\hat{G}(\mathbf{\omega})$ 매핑을 **인공신경망 가중치(Weights)로 데이터 기반 학습**을 해버립니다.

그 결과, 아무리 복잡한 $K(\mathbf{x})$ 지도가 주어져도 FNO는 푸리에 공간으로 넘어가 단순히 가중치 행렬을 곱하고 돌아오는 것만으로 기존 해석기법보다 수천 배 빠르게 압력 함수 $p(\mathbf{x})$를 정확히 예측해 냅니다.